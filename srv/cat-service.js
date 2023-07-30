const cds = require('@sap/cds')

const SCOREMAPPING = {
    "-3": "albatross",
    "-2": "eagle",
    "-1": "birdie",
    "0" : "par",
    "1" : "bogey",
    "2" : "double bogey",
    "3" : "triple bogey"
};

const calculateResult = (par, score) => {
    if( score == 1){
        return "hole in one"
    }  else {
        const res = score - par
        return SCOREMAPPING[ res.toString() ]
    }
}

module.exports = class GolfService extends cds.ApplicationService {
    async init() {
        console.log("reached init...")
        const { Holes, Rounds } = this.entities
        
        // CREATE by Association Rounds.holes
        this.before(['CREATE', 'UPDATE'], Rounds.holes, req => {
            log.info('CBA Rounds.holes', req.data.score, req.data.par)
            req.data.result = calculateResult(req.data.par, req.data.score)
        })
        
        // CREATE operation on entiyt Holes
        this.before ('CREATE', Holes, req => {          
            req.data.result = calculateResult(req.data.par, req.data.score)
        })

        const remote = await cds.connect.to("RemoteService")
        this.on('*', 'Players', (req) => {
            console.log(">> delegating to remote service")
            return remote.run(req.query)
        })

        return super.init()
    }
}