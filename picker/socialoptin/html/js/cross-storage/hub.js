/**
 * cross-storage - Cross domain local storage
 *
 * @version   0.8.0
 * @link      https://github.com/zendesk/cross-storage
 * @author    Daniel St. Jules <danielst.jules@gmail.com>
 * @copyright Zendesk
 * @license   Apache-2.0
 */

!function(e){var r={};r.init=function(e){var t=!0;try{window.localStorage||(t=!1)}catch(n){t=!1}if(!t)try{return window.parent.postMessage("cross-storage:unavailable","*")}catch(n){return}r._permissions=e||[],r._installListener(),window.parent.postMessage("cross-storage:ready","*")},r._installListener=function(){var e=r._listener;window.addEventListener?window.addEventListener("message",e,!1):window.attachEvent("onmessage",e)},r._listener=function(e){var t,n,o,s,i;if("cross-storage:poll"===e.data)return window.parent.postMessage("cross-storage:ready",e.origin);if("cross-storage:ready"!==e.data&&(t=JSON.parse(e.data),n=t.method.split("cross-storage:")[1])){if(r._permitted(e.origin,n))try{s=r["_"+n](t.params)}catch(a){o=a.message}else o="Invalid permissions for "+n;i=JSON.stringify({id:t.id,error:o,result:s}),window.parent.postMessage(i,e.origin)}},r._permitted=function(e,t){var n,o,s,i;if(n=["get","set","del","clear","getKeys"],!r._inArray(t,n))return!1;for(o=0;o<r._permissions.length;o++)if(s=r._permissions[o],s.origin instanceof RegExp&&s.allow instanceof Array&&(i=s.origin.test(e),i&&r._inArray(t,s.allow)))return!0;return!1},r._set=function(e){var t,n;if(t=e.ttl,t&&parseInt(t,10)!==t)throw new Error("ttl must be a number");n={value:e.value},t&&(n.expire=r._now()+t),window.localStorage.setItem(e.key,JSON.stringify(n))},r._get=function(e){var t,n,o,s,i;for(t=window.localStorage,n=[],o=0;o<e.keys.length;o++)i=e.keys[o],s=JSON.parse(t.getItem(i)),null===s?n.push(null):s.expire&&s.expire<r._now()?(t.removeItem(i),n.push(null)):n.push(s.value);return n.length>1?n:n[0]},r._del=function(e){for(var r=0;r<e.keys.length;r++)window.localStorage.removeItem(e.keys[r])},r._clear=function(){window.localStorage.clear()},r._getKeys=function(){var e,r,t;for(t=[],r=window.localStorage.length,e=0;r>e;e++)t.push(window.localStorage.key(e));return t},r._inArray=function(e,r){for(var t=0;t<r.length;t++)if(e===r[t])return!0;return!1},r._now=function(){return"function"==typeof Date.now?Date.now():(new Date).getTime()},"undefined"!=typeof module&&module.exports?module.exports=r:"undefined"!=typeof exports?exports.CrossStorageHub=r:"function"==typeof define&&define.amd?define("CrossStorageHub",[],function(){return r}):e.CrossStorageHub=r}(this);