// ==UserScript==
// @name        SO hot questions
// @include     https://stackoverflow.com/*
// @run-at      document-start
// ==/UserScript==

function zzz(){
    var z1=document.getElementById('hot-network-questions');
    z1.parentElement.removeChild(z1);
    var z2=document.getElementById('left-sidebar');
    z2.parentElement.removeChild(z2);
}

console.log ("==> Script start.", new Date() );

// 1ST PART OF SCRIPT RUN GOES HERE.
console.log ("==> 1st part of script run.", new Date() );

document.addEventListener ("DOMContentLoaded", DOM_ContentReady);
window.addEventListener ("load", pageFullyLoaded);

function DOM_ContentReady () {
    // 2ND PART OF SCRIPT RUN GOES HERE.
    // This is the equivalent of @run-at document-end
    zzz();
    console.log ("!!!==> 2nd part of script run.", new Date() );
}

function pageFullyLoaded () {
    console.log ("==> Page is fully loaded, including images.", new Date() );
}

console.log ("==> Script end.", new Date() );
