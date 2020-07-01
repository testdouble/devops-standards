Run Prowler (https://github.com/toniblyx/prowler)
```./prowler -g cislevel2 -r region -M json```

Move output to input folder under this project.  DO NOT CHECK IN JSON!
```node ./index.js node ./index.js -f "./test-data/sgp.json" --out ./output/sgp.html -c Roche ```
DO NOT CHECK IN HTML!

Install wkhtmltopdf (https://wkhtmltopdf.org/downloads.html)

Run wkhtmltopdf passing in the .html and the output pdf file as below.  Make
sure to use the  --print-media-type param.

```wkhtmltopdf report.html --print-media-type cmd.pdf```

DO NOT CHECK IN PDF!