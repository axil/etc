// ==UserScript==
// @name         reactjs in english
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       You
// @match        https://ru.reactjs.org/*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';
    document.location = document.location.href.replace('ru.', '')
    // Your code here...
})();