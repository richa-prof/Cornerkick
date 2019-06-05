import {Cornerkick} from "cornerkick/cornerkick";

function cornerkickInit() {
    let ckId: string = window.ckId;
    let ckDomain = window.ckDomain;
    let collectorUrl = `//${ckDomain}/collect/${ckId}`;

    let cornerkick = new Cornerkick(collectorUrl);
    cornerkick.start();
}

if(document.readyState == 'complete' || document.readyState == 'interactive') {
    cornerkickInit();
}
else {
    window.addEventListener('DOMContentLoaded', cornerkickInit);
}
