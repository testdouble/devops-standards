const fs = require('fs');
const _ = require('lodash');
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
let grouped = _.groupBy(json,"Control ID");
let audit = [];
for (a in grouped){
    let test = grouped[a].reduce((n,o) => {
        (n.Results || (n.Results = [])).push({"Status": o.Status, "Message": o.Message});
        n.Profile = o.Profile;
        n["Account Number"] = o["Account Number"];
        n["Control ID"] = o["Control ID"];
        n.Control = o.Control;
        n.Scored = o.Scored;
        n.Severity = o.Severity;
        n.Level = o.Level;
        n.Region = o.Region;
        return n;
    },{});
    audit.push(test);
    console.log(audit);
}
fs.writeFileSync('report.json',JSON.stringify(audit));
const compiledFunction = pug.compileFile('./assets/template.pug');
fs.writeFileSync(out,compiledFunction({'json': audit, 'moment': moment, 'customer' : customer}));