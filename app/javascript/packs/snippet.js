(function(d, s, domain, identifier, existing, lib) {
    window['ckId'] = identifier;
    window['ckDomain'] = domain;
    existing = d.getElementsByTagName(s)[0];
    lib = d.createElement(s);
    lib.async = true;
    lib.src = 'https://' + domain + '/cornerkick.lib.min.js';
    existing.parentNode.insertBefore(lib, existing);
})(document, 'script', dom, id);




//
// (function (window, document, libUrl, ckFunc, identifier) {
//     window[ckFunc] = window[ckFunc] || function() {
//             window[ckFunc].settings = window[ckFunc].settings || [];
//             window[ckFunc].settings[arguments[0]] = arguments[1];
//         };
//     var existing = document.getElementsByTagName('script')[0];
//     var lib = document.createElement('script');
//     lib.async = true;
//     lib.src = libUrl;
//     if (existing !== null) {
//         existing.parentNode.insertBefore(lib, existing);
//     }
// })(window, document, '/cornerkick.lib.min.js', 'ck');
//
// ck('id', 'CK-4485858');
// ck('track.forms', true);
