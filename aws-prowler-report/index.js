const fs = require('fs');
const _ = require('lodash');
var pdf = require('html-pdf');
const pug = require('pug');
const moment = require('moment');
const { program } = require('commander');


program.version('0.0.1');
program.option('-f, --file <file>', 'prowler json output',"./input/test-data/prowler-output-sample.json")
program.option('-o, --out <file>', 'output html', './output/report.html')
program.option('-c, --customer <name>', 'customer for report', 'ACME')
program.parse(process.argv);
let raw = `${program.file}`;
let out = `${program.out}`;
let customer = `${program.customer}`;
//let raw = 'prowler-output-sample.json'
let file = fs.readFileSync(raw);
let json = file.toString().trim().split('\n').map(JSON.parse);

// The severity needs to correspond with static ints to easily
// sort the audit array
const SeveritySortHash ={
    "Critical": -2,
    "High": -1,
    "Medium": 0,
    "Low": 1
}

let grouped = _.groupBy(json,"Control ID");

let audit = [];

for (a in grouped){
    let test = grouped[a]
        .reduce((n,o) => {
        (n.Results || (n.Results = [])).push({"Status": o.Status, "Message": o.Message});
        n.Profile = o.Profile;
        n["Account Number"] = o["Account Number"];
        n["Control ID"] = o["Control ID"];
        n.Control = o.Control;
        n.Severity = o.Severity;
        n.Region = o.Region;
        return n;
    },{});
    audit.push(test);
}

// sort the entire audit array by severity
audit.sort((a,b) => SeveritySortHash[a.Severity] - SeveritySortHash[b.Severity])

// this is where the output files get written
fs.writeFileSync('report.json',JSON.stringify(audit));

const compiledFunction = pug.compileFile('./assets/template.pug');
fs.writeFileSync(out, compiledFunction({'json': audit, 'moment': moment, 'customer' : customer}));


// this is the config portions for the generatation of the pdf
// let options = { format: 'A4', path: './output/output.pdf' };
var outHtml = fs.readFileSync(out, 'utf8');

// let htmlFile = { content: outHtml.toString() };
// html_to_pdf.generatePdf(htmlFile, options)


pdf.create(outHtml, { format: 'Letter'}).toFile('./output/output.pdf', () => {});