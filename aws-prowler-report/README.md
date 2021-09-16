## Installation
Run `npm install` or `yarn install` using Node > 13.X
## Instructions
1. Run Prowler (https://github.com/toniblyx/prowler)
```./prowler -g cislevel2 -r region -M json```
3. Move output to the input folder under this project.  DO NOT CHECK IN JSON!
4. Run the script: ```node ./index.js -f "<path-to-input-file>.json" --out <path-to-output-file>.html -c <customer-name> ```

