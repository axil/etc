// ==UserScript==
// @name         simplenote
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       You
// @match        https://app.simplenote.com/
// @grant        none
// ==/UserScript==

// callback executed when canvas was found
function handleCanvas(canvas) {
    canvas[0].style.maxWidth="1780px"
}

// set up the mutation observer
var observer = new MutationObserver(function (mutations, me) {
  // `mutations` is an array of mutations that occurred
  // `me` is the MutationObserver instance
  var canvas = document.getElementsByClassName('note-detail-textarea');
  if (canvas) {
    handleCanvas(canvas);
    me.disconnect(); // stop observing
    return;
  }
});

(function() {
    'use strict';

    // start observing
    observer.observe(document, {
        childList: true,
        subtree: true
    });

})();