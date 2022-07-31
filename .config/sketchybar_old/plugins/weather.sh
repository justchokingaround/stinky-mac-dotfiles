#!/bin/zsh

API_KEY="" # insert api key here (you can get one for free on openweathermap.org)
CITY="" # insert city here
LAT="" # insert latitude here
LON="" # insert longitude here

# choose your units of measurement
METRIC="units=metric" 
IMPERIAL="units=imperial"


# exhaustive list of weather icons (day)
weather_icons_day=(
    [800]=  # Clear sky(01d/n)
    [801]=  # Few clouds(02d/n)
    [802]=  # Scattered clouds(03d/n)
    [803]=  # Broken clouds(04d/n)
    [804]=  # Overcast clouds(04d/n)

    [701]=  # Mist(50d)
    [711]=  # Smoke(50d)
    [721]=  # Haze(50d)
    [731]=  # Sand/dust swirls(50d)
    [741]=  # Fog(50d)
    [751]=  # Sand(50d)
    [761]=  # Dust(50d)
    [762]=  # Ash(50d)
    [771]=  # Squall(50d)
    [781]=  # Tornado(50d)

    [500]=  # Light rain(10d)
    [501]=  # Moderate rain(10d)
    [502]=  # Heavy rain(10d)
    [503]=  # Very heavy rain(10d)
    [504]=  # Extreme rain(10d)
    [511]=  # Freezing rain(13d)
    [520]=  # Light shower rain(09d)
    [521]=  # Shower rain(09d)
    [522]=  # Heavy shower rain(09d)
    [531]=  # Ragged shower rain(09d)

    [200]=  # Thunderstorm with light rain(11d)
    [201]=  # Thunderstorm with rain(11d)
    [202]=  # Thunderstorm with heavy rain(11d)
    [210]=  # Light thunderstorm(11d)
    [211]=  # Thunderstorm(11d)
    [212]=  # Heavy thunderstorm(11d)
    [221]=  # Ragged thunderstorm(11d)
    [230]=  # Thunderstorm with light drizzle(11d)
    [231]=  # Thunderstorm with drizzle(11d)
    [232]=  # Thunderstorm with heavy drizzle(11d)

    [300]=  # Light drizzle(09d)
    [301]=  # Drizzle(09d)
    [302]=  # Heavy drizzle(09d)
    [310]=  # Light drizzle rain(09d)
    [311]=  # Drizzle rain(09d)
    [312]=  # Heavy drizzle rain(09d)
    [313]=  # Shower rain & drizzle(09d)
    [314]=  # Heavy shower rain & drizzle(09d)
    [321]=  # Shower drizzle(09d)

    [600]=  # Light snow(13d)
    [601]=  # Snow(13d)
    [602]=  # Heavy snow(13d)
    [611]=  # Sleet(13d)
    [612]=  # Light shower sleet(13d)
    [613]=  # Shower sleet(13d)
    [615]=  # Light rain & snow(13d)
    [616]=  # Rain & snow(13d)
    [620]=  # Light shower snow(13d)
    [621]=  # Shower snow(13d)
    [622]=  # Heavy shower snow(13d)
)

# exhaustive list of weather icons (night)
weather_icons_night=(
    [800]=  # Clear sky(01d/n)
    [801]=  # Few clouds(02d/n)
    [802]=  # Scattered clouds(03d/n)
    [803]=  # Broken clouds(04d/n)
    [804]=  # Overcast clouds(04d/n)

    [701]=  # Mist(50d)
    [711]=  # Smoke(50d)
    [721]=  # Haze(50d)
    [731]=  # Sand/dust swirls(50d)
    [741]=  # Fog(50d)
    [751]=  # Sand(50d)
    [761]=  # Dust(50d)
    [762]=  # Ash(50d)
    [771]=  # Squall(50d)
    [781]=  # Tornado(50d)

    [500]=  # Light rain(10d)
    [501]=  # Moderate rain(10d)
    [502]=  # Heavy rain(10d)
    [503]=  # Very heavy rain(10d)
    [504]=  # Extreme rain(10d)
    [511]=  # Freezing rain(13d)
    [520]=  # Light shower rain(09d)
    [521]=  # Shower rain(09d)
    [522]=  # Heavy shower rain(09d)
    [531]=  # Ragged shower rain(09d)

    [200]=  # Thunderstorm with light rain(11d)
    [201]=  # Thunderstorm with rain(11d)
    [202]=  # Thunderstorm with heavy rain(11d)
    [210]=  # Light thunderstorm(11d)
    [211]=  # Thunderstorm(11d)
    [212]=  # Heavy thunderstorm(11d)
    [221]=  # Ragged thunderstorm(11d)
    [230]=  # Thunderstorm with light drizzle(11d)
    [231]=  # Thunderstorm with drizzle(11d)
    [232]=  # Thunderstorm with heavy drizzle(11d)

    [300]=  # Light drizzle(09d)
    [301]=  # Drizzle(09d)
    [302]=  # Heavy drizzle(09d)
    [310]=  # Light drizzle rain(09d)
    [311]=  # Drizzle rain(09d)
    [312]=  # Heavy drizzle rain(09d)
    [313]=  # Shower rain & drizzle(09d)
    [314]=  # Heavy shower rain & drizzle(09d)
    [321]=  # Shower drizzle(09d)

    [600]=  # Light snow(13d)
    [601]=  # Snow(13d)
    [602]=  # Heavy snow(13d)
    [611]=  # Sleet(13d)
    [612]=  # Light shower sleet(13d)
    [613]=  # Shower sleet(13d)
    [615]=  # Light rain & snow(13d)
    [616]=  # Rain & snow(13d)
    [620]=  # Light shower snow(13d)
    [621]=  # Shower snow(13d)
    [622]=  # Heavy shower snow(13d)
)   


CITY=$(echo "$CITY" | curl -Gso /dev/null -w %{url_effective} --data-urlencode @- "" | cut -c 3- || true)
data=$(curl -s "https://api.openweathermap.org/data/2.5/weather?lat=$LAT&lon=$LON&appid=$API_KEY&$METRIC")
condition=$(echo $data | jq -r '.weather[].id')
temp=$(echo $data | jq -r '.main.temp')
feelslike=$(echo $data | jq -r '.main.feels_like')
humidity=$(echo $data | jq -r '.main.humidity')
is_day=$(echo $data | jq -r '.dt')

[ "$is_day" = "1" ] && icon=$weather_icons_day[$condition] || icon=$weather_icons_night[$condition]

sketchybar -m \
    --set weather \
        icon="$icon" \
        label="${temp}°C"

