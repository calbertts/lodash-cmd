# Lodash from Command Line

Lodash natively available from command line (No NPM and NodeJS required)

Take note this isn't a re-write of lodash, but just lodash compiled to native code.

This is not intended to be fast but be small (~1.2MB) and portable in embedded systems and containers.
It uses https://lodash.com (4.17.15) as well as https://github.com/substack/minimist to parse command line arguments.

## How to install

This downloads and installs the latest binary depending on your OS (Windows isn't supported yet):

```
curl -sL https://raw.githubusercontent.com/calbertts/lodash-cmd/master/install.sh | sh
```

## How to use

##### Available options:
- **file**
- **url**

The utility can be used as a command line program independently or can be part of a pipeline:

##### Syntax:
```
_ [method] [input --file or --url] [params]
```
A full of method's list can be found here: https://lodash.com/docs/4.17.15

##### Examples:
```
# passing params directly:
_ difference "[2, 1]" "[2, 3]"
# returns: [1]

# from URL (requires cURL):
_ get "'dependencies.@babel/code-frame.version'" --url https://raw.githubusercontent.com/lodash/lodash/master/package-lock.json
# returns: "7.5.5"

# pipeline (input through stdin), stdin is the default input unless --file or --url are used:
echo '[2, 1]' | _ difference "[2, 3]" | _ head
# returns: 1

# JS functions can be used as parameters as the same way as lodash from NodeJS or the browser
_ find \
  "[ { 'user': 'barney', 'active': false }, { 'user': 'fred', 'active': false }, { 'user': 'pebbles', 'active': true } ]" \
  "(o) => o.user == 'barney'"
  # returns: {"user":"barney","active":false}
```

## How to uninstall
Since this is a small binary with no dependencies, just remove it:
```
rm ~/.calbertts_tools/_
```

## How to build

This project requires the QuickJS compiler to be previously installed https://bellard.org/quickjs/
Then just run:
```
make
```

## How to test
This file contains several examples that you can look up to get started, not all cases are included.
```
chmod a+x ./test.sh
./test.sh
```

