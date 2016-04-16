# Security Policy

A bit barebones, but essentially a list of things to be aware of to try to secure things as much as possible.

## ToDo

1. Investigate clickjacking. I doubt we could be vulnerable to this, but it may be possible in the future.
2. Test with Burp Suite ?
3. Check Lapis's HTML entity encoding, it may not be sufficient. (They do not escape forward slashes, but this does not seem 100% needed either.)
4. Read up on Phishing and try to mitigate what I can: https://www.owasp.org/index.php/Phishing
5. Work on data validation (specifically when allowing a user to input a URL): https://www.owasp.org/index.php/Data_Validation
6. Read up on various forms of attack and do what I can to stop them: https://www.owasp.org/index.php/Category:Attack
7. Disable unused HTTP methods:
    ```
    if ($request_method !~ ^(GET|POST)$ )
    {
        return 444;
    }
    ```
8. **URGENT**: User-input data is being used in attributes without being escaped, this may be safe, but might not be. (Ex: A user submitting a form is safe, a site being displayed using data from the database in an attribute is **not**.)
9. Read session management guide: https://www.owasp.org/index.php/Session_Management_Cheat_Sheet
10. Read more about Nginx server hardening: http://www.cyberciti.biz/tips/linux-unix-bsd-nginx-webserver-security.html
11. Read more about Nginx in general, maybe there's something I haven't seen/read in the rest of this... https://wiki.archlinux.org/index.php/Nginx
12. Read OWASP's dev guide: https://github.com/OWASP/DevGuide
13. Read up on code review: https://www.owasp.org/images/2/2e/OWASP_Code_Review_Guide-V1_1.pdf
14. Read OWASP's testing guide: https://www.owasp.org/index.php/OWASP_Testing_Guide_v4_Table_of_Contents
15. Apparently, these might need to be escaped too? [source](https://www.owasp.org/index.php/Reviewing_Code_for_Cross-site_scripting)
    ```
    (	&#40;
    )	&#41;
    #	&#35;
    ```
17. Use this attack tool? http://xss-proxy.sourceforge.net/
    Run this? https://www.owasp.org/index.php/OWASP_Zed_Attack_Proxy_Project
    Yet another XSS tool... https://www.owasp.org/index.php/OWASP_Xenotix_XSS_Exploit_Framework

## XSS (Cross-Site Scripting)

HTML entity encoding is done for us by Lapis, however, there are a few places where no matter what is done, XSS cannot be blocked by this method:

> But HTML entity encoding doesn't work if you're putting untrusted data inside a <script> tag anywhere, or an event handler attribute like onmouseover, or inside CSS, or in a URL.

[source][1]

Do **not** use user-input data in any of the following:

- `<script>` tags
- in an HTML comment
- tag names
- attribute names
- event handler attributes (ex: onmouseover, onclick)
- inside CSS
- in a URL

Do **not** use user-input data in any attribute without escaping:

> Except for alphanumeric characters, escape all characters with ASCII values less than 256 with the &#xHH; format (or a named entity if available) to prevent switching out of the attribute. The reason this rule is so broad is that developers frequently leave attributes unquoted. Properly quoted attributes can only be escaped with the corresponding quote. Unquoted attributes can be broken out of with many characters, including [space] % * + , - / ; < = > ^ and |.

[source][1]

Don't use user-input data in JavaScript without escaping.. (but I will not use it *at all*) As mentioned above, JSON and CSS can also be very dangerous is not handled correctly, but I am not using them.

These are pulled straight from [OWASP][1].

### Tools for checking XSS vulnerabilities:

- [DOM XSS Scanner](http://www.domxssscanner.com/), web service, does a simple scan of data from server to see if it uses dangerous sinks.
- [Ra.2 DOM XXSS Scanner](https://code.google.com/archive/p/ra2-dom-xss-scanner/), a more complex scan involving submitting exploits and testing for them getting through.
- [DOM Snitch](https://googleonlinesecurity.blogspot.com/2011/06/introducing-dom-snitch-our-passive-in.html), Google Chrome add-on, tracks any time the DOM is modified, and reports when unsafe code is run.
- [DOMinator](https://dominator.mindedsecurity.com/), another scanner, has a pro version..

[1]: https://www.owasp.org/index.php/XSS_(Cross_Site_Scripting)_Prevention_Cheat_Sheet
