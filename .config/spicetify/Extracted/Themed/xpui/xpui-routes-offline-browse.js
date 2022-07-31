"use strict";(("undefined"!=typeof self?self:global).webpackChunkopen=("undefined"!=typeof self?self:global).webpackChunkopen||[]).push([[1997],{54543:(e,t,a)=>{a.d(t,{q:()=>T});var n=a(87462),r=a(67294),i=a(69518),s=a.n(i),l=a(63495),c=a(36590),d=a(8498),m=a(13781),o=a(11186);const u=({name:e="",uri:t="",images:a=[],isHero:n,onClick:i,testId:s,index:l})=>n?r.createElement(m.Z,{featureIdentifier:"unknown",index:l,onClick:i,headerText:e,uri:t,isPlayable:!1,renderCardImage:()=>r.createElement(d.x,{isHero:n,images:a}),renderSubHeaderContent:()=>r.createElement(o.k,null),testId:s}):r.createElement(c.C,{index:l,featureIdentifier:"unknown",onClick:i,headerText:e,uri:t,isPlayable:!1,renderCardImage:()=>r.createElement(d.x,{isHero:n,images:a}),renderSubHeaderContent:()=>r.createElement("span",null),testId:s});var g=a(73425),E=a(143),p=a(64269),I=a(3634),C=a(89477),f=a(16061),x=a(46309),y=a(30523),h=a(52778),b=a(95332),k=a(46327);const T=({entity:e,index:t,testId:a,isHero:i=!1})=>{const c=(s().from(e.uri)||{}).type,d={testId:a,isHero:i,index:t,sharingInfo:e.sharingInfo};switch(c){case s().Type.ALBUM:case s().Type.COLLECTION_ALBUM:{const t=e;return r.createElement(I.r,(0,n.Z)({},d,{name:t.name,uri:t.uri,images:t.images,artists:t.artists}))}case s().Type.ARTIST:{const t=e;return r.createElement(C.I,(0,n.Z)({},d,{name:t.name,uri:t.uri,images:t.images}))}case s().Type.EPISODE:{const t=e;return r.createElement(f.B,(0,n.Z)({},d,{name:t.name,uri:t.uri,images:t.images,showImages:t.show?.images||[],durationMilliseconds:t.duration_ms,releaseDate:t.release_date,resume_point:t.resume_point,description:t.description,isExplicit:t.explicit,is19PlusOnly:!!t.tags?.includes("MOGEF-19+")}))}case s().Type.PLAYLIST:case s().Type.PLAYLIST_V2:{const t=e,a=t.owner?.display_name||e.owner?.displayName||"";return r.createElement(x.Z,(0,n.Z)({},d,{name:t.name,uri:t.uri,images:t.images,description:t.description,authorName:a}))}case s().Type.USER:return r.createElement(y.P,(0,n.Z)({},d,{name:e.name,uri:e.uri,images:e.images}));case s().Type.SHOW:{const t=e;return r.createElement(b._,(0,n.Z)({},d,{name:t.name,uri:t.uri,images:t.images,publisher:t.publisher,mediaType:{audio:E.E.AUDIO,video:E.E.VIDEO,mixed:E.E.MIXED}[t.media_type]??E.E.AUDIO}))}case s().Type.APPLICATION:return r.createElement(l.s,(0,n.Z)({},d,{name:e.name,uri:e.uri,images:e.images,description:e.description}));case s().Type.RADIO:return r.createElement(h.I,{testId:a,index:t,name:e.name,uri:e.uri,images:e.images});case s().Type.TRACK:{const t=e;return r.createElement(k.G,(0,n.Z)({},d,{name:t.name,uri:t.uri,images:t.album?.images||[],artists:t.artists,album:t.album,isExplicit:t.explicit,is19PlusOnly:t.tags?.includes("MOGEF-19+")}))}case s().Type.COLLECTION:return e.uri.endsWith("your-episodes")?r.createElement(p.T,{index:t}):r.createElement(g.p,{index:t});default:return console.warn("Rendering a generic Card for unknown type:",c),r.createElement(u,(0,n.Z)({},d,{name:e.name,uri:e.uri,images:e.images}))}}},16061:(e,t,a)=>{a.d(t,{B:()=>H});var n=a(87462),r=a(67294),i=a(96206),s=a(18261),l=a(87257),c=a(57978),d=a(80418),m=a(34325),o=a(43315),u=a(49961),g=a(25988),E=a(36590),p=a(8498),I=a(28760),C=a(97605),f=a(85392);const x="z4popIk32AsyDKlV1o1v",y="_xxuonqkZEQ7pCffxlUD",h=r.memo((function(e){const{src:t,description:a,...i}=e,[s,l]=(0,r.useState)("inherit");return(0,r.useEffect)((()=>{t&&async function(e){const{colorRaw:t}=await(0,f.b)(e),{h:a,s:n,l:r}=t.hsl,i=`hsl(${360*a}, ${100*n}%, ${Math.min(100*r,30)}%)`;l(i)}(t)}),[t]),t?r.createElement("div",{className:x,style:{backgroundColor:s},"data-testid":"episode-fallback-image-container"},r.createElement("div",{className:y},r.createElement(I.Dy,{as:"p",variant:"canon"},a))):r.createElement(C.J,(0,n.Z)({},i,{iconSize:64}))}));var b=a(13781),k=a(11186);const T="x1FErCk9Xh9VumpOLyfm",w="heeHk6hz8sAXLIU6P6an",N="Hhfi1xnYwoHoMP2rcltS",H=({description:e,isExplicit:t,images:a,name:I,uri:C,durationMilliseconds:f,releaseDate:x,resume_point:y,showImages:H,sharingInfo:S,is19PlusOnly:P,isHero:v,onClick:O,testId:Z,index:_,requestId:L})=>{let A;const D=x?new Date(x):void 0,q=D&&!isNaN(D.getTime())&&!isNaN(f),M=(0,u.X)(H,{desiredSize:48}),z=(0,m.G3)(C,D?.toISOString(),y?.resume_position_ms,y?.fully_played);return A=v?r.createElement(b.Z,{index:_,onClick:O,headerText:I,featureIdentifier:"episode",uri:C,isPlayable:!1,isDownloadable:!0,hasNewEpisodeIndicator:z,renderCardImage:()=>r.createElement(p.x,{isHero:!0,images:a,FallbackComponent:t=>r.createElement(h,(0,n.Z)({},t,{description:e,src:M&&M.url}))},M&&r.createElement(d.E,{loading:"lazy",src:M.url,className:T,radius:4})),renderSubHeaderContent:()=>r.createElement(r.Fragment,null,t&&!P&&r.createElement(l.N,{className:w}),P&&r.createElement(c.X,{size:16,className:w}),q&&r.createElement("span",{className:N},D&&(0,o.rL)(D)," ·"," ",i.ag.get("episode.length",Math.ceil(f/6e4))),r.createElement(k.k,null,i.ag.get("card.tag.episode"))),testId:Z,requestId:L}):r.createElement(E.C,{index:_,onClick:O,headerText:I,featureIdentifier:"episode",uri:C,isPlayable:!1,isDownloadable:!0,hasNewEpisodeIndicator:z,renderCardImage:()=>r.createElement(p.x,{images:a,FallbackComponent:t=>r.createElement(h,(0,n.Z)({},t,{description:e,src:M&&M.url}))},M&&r.createElement(d.E,{loading:"lazy",src:M.url,className:T,radius:4,testid:"episode-card-show-image"})),renderSubHeaderContent:()=>r.createElement(r.Fragment,null,t&&!P&&r.createElement(l.N,{className:w}),P&&r.createElement(c.X,{size:16,className:w}),q&&r.createElement("span",{className:N},D&&(0,o.rL)(D)," ·"," ",i.ag.get("episode.length",Math.ceil(f/6e4)))),testId:Z,requestId:L}),r.createElement(s._,{menu:r.createElement(g.k,{uri:C,sharingInfo:S})},A)}},63495:(e,t,a)=>{a.d(t,{s:()=>d});var n=a(67294),r=a(96206),i=a(36590),s=a(8498),l=a(13781),c=a(11186);const d=({name:e,uri:t,images:a,isHero:d,onClick:m,testId:o,description:u,index:g,requestId:E})=>d?n.createElement(l.Z,{featureIdentifier:"genre",index:g,onClick:m,headerText:e,uri:t,isPlayable:!1,renderCardImage:()=>n.createElement(s.x,{isHero:d,images:a}),renderSubHeaderContent:()=>n.createElement(c.k,null,u||r.ag.get("card.tag.genre")),testId:o,requestId:E}):n.createElement(i.C,{index:g,featureIdentifier:"genre",onClick:m,headerText:e,uri:t,isPlayable:!1,renderCardImage:()=>n.createElement(s.x,{isHero:d,images:a}),renderSubHeaderContent:()=>n.createElement("span",null,u||""),testId:o,requestId:E})},30523:(e,t,a)=>{a.d(t,{P:()=>g});var n=a(87462),r=a(67294),i=a(5843),s=a(96206),l=a(18261),c=a(43480),d=a(36590),m=a(8498),o=a(13781),u=a(11186);const g=r.memo((function(e){const{images:t,name:a,uri:g,onClick:E,isHero:p,testId:I,index:C,requestId:f}=e;let x;const y=(0,r.useCallback)((()=>r.createElement(m.x,{isCircular:!0,isHero:p,images:t,FallbackComponent:e=>r.createElement(i.a,(0,n.Z)({iconSize:64},e))})),[t,p]),h=(0,r.useCallback)((()=>p?r.createElement(u.k,null,s.ag.get("card.tag.profile")):s.ag.get("card.tag.profile")),[p]);return x=p?r.createElement(o.Z,{index:C,onClick:E,headerText:a,featureIdentifier:"profile",uri:g,isPlayable:!1,renderCardImage:y,renderSubHeaderContent:h,testId:I,requestId:f}):r.createElement(d.C,{index:C,onClick:E,headerText:a,featureIdentifier:"profile",uri:g,isPlayable:!1,renderCardImage:y,renderSubHeaderContent:h,testId:I,requestId:f}),r.createElement(l._,{menu:r.createElement(c.I,{uri:g})},x)}))},59882:(e,t,a)=>{a.r(t),a.d(t,{default:()=>g});var n=a(67294),r=a(94184),i=a.n(r),s=a(96206),l=a(54543),c=a(19480),d=a(42922),m=a(26010);const o="GIPNS6CX3VGw43hv6CQv";function u(){const{useOfflineEntities:e}=(0,n.useContext)(m.I),[t,a,r]=e();if(r)return null;const u=a?[]:t;if(!u.length)return null;const g=[{title:s.ag.get("music_downloads"),content:u}];return n.createElement("div",{className:i()(o,"contentSpacing")},g.map((e=>n.createElement("div",{key:e.title},n.createElement(d.JL,{value:"headered-grid"},n.createElement(c.P,{title:e.title,total:e.content.length,seeAllUri:"/collection/music-downloads"},e.content.map(((e,t)=>n.createElement(d.JL,{key:e.uri,value:"card",index:t},n.createElement(l.q,{entity:e,index:t}))))))))))}const g=u}}]);
//# sourceMappingURL=xpui-routes-offline-browse.js.map