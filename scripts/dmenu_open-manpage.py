#!/usr/bin/env python
# philipp.glira@gmail.com
# https://github.com/pglira

import argparse
import os
import sys
import shutil
import subprocess
import tempfile


def parse_args(args_in):
    def program_type(value):
        if shutil.which(value.split()[0]) is None:
            msg = 'Program "{}" not found!'.format(value)
            raise argparse.ArgumentTypeError(msg)
        return value

    # Define own formatter which combines multiple formatters
    class Formatter(argparse.ArgumentDefaultsHelpFormatter,
        argparse.RawDescriptionHelpFormatter): pass

    scriptname = os.path.basename(__file__)
    description = 'Use dmenu to open a manpage as pdf or text file.'
    examples = []
    examples.append('{} -p okular'.format(scriptname))
    examples.append('{} -a txt -p gnome-text-editor'.format(scriptname))
    examples.append('{} -a txt -p "$TERMINAL -e vim"'.format(scriptname))
    epilog = 'Examples:\n  ' + '\n  '.join(examples)
    parser = argparse.ArgumentParser(description=description, formatter_class=Formatter,
        epilog=epilog)
    parser._action_groups.pop()
    required = parser.add_argument_group('required arguments')
    optional = parser.add_argument_group('optional arguments')
    optional.add_argument('-a', '--open-as', help='Open manpage as ...', dest='open_as',
        required=False, choices=['pdf', 'txt'], default='pdf')
    optional.add_argument('-p', '--program', help='Program to open file', dest='program',
        required=False, type=program_type, default='xdg-open')
    optional.add_argument('-o', '--dmenu-options', help='Options to pass to dmenu',
        dest='dmenu_options', required=False, type=str, default='')
    args = parser.parse_args(args_in)

    return args


def get_commands():
    commands = subprocess.run(['man', '-k', '.'], stdout=subprocess.PIPE,
        encoding='utf8').stdout.splitlines()
    commands = sorted(commands)
    return commands


def select_command(commands, dmenu_options):
    if shutil.which('dmenu') is None:
        print('Error: "dmenu" not found on path!')
        sys.exit(1)
    input_string = '\n'.join(commands) + '\n'
    command = ['dmenu'] + dmenu_options.split()
    process = subprocess.Popen(command, stdout=subprocess.PIPE, stdin=subprocess.PIPE,
        encoding='utf8')
    selected_command_with_description = process.communicate(input_string)[0].rstrip()
    if process.returncode != 0:
        sys.exit(1)
    selected_command = selected_command_with_description.split()[0]
    return selected_command


def create_manpage_file(selected_command, format):
    manpage_file = os.path.join(tempfile.gettempdir(), 'manpage.' + format)
    if format == 'pdf':
        command_man = subprocess.run(['man', '-t', selected_command], stdout=subprocess.PIPE)
        subprocess.run(['ps2pdf', '-', manpage_file], input=command_man.stdout)
    elif format == 'txt':
        command_man = subprocess.run(['man', selected_command], stdout=subprocess.PIPE,
            encoding='utf8')
        with open(manpage_file, 'w') as f:
            subprocess.run(['col', '-bx'], input=command_man.stdout, stdout=f, encoding='utf8')
    return manpage_file


def open_manpage(manpage_file, program):
    if not os.path.isfile(manpage_file):
        print('File "{}" not found!'.format(manpage_file))
        sys.exit(1)
    command = program.split() + [manpage_file]
    process = subprocess.run(command, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)


def main(args_in):
    args = parse_args(args_in)
    commands = get_commands()
    selected_command = select_command(commands, args.dmenu_options)
    manpage_file = create_manpage_file(selected_command, args.open_as)
    open_manpage(manpage_file, args.program)


if __name__ == '__main__':
    main(sys.argv[1:])

