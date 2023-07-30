const cds = require('@sap/cds')
const log = cds.log('exit')

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
    if ( score == 1 ){
        return 100
    }

    let res = score - par;
    
    if( res > 3 || res < -3 ) {
        return 99
    }

    return res
}

module.exports = class GolfService extends cds.ApplicationService {
    async init() {
        console.log("reached init...")
        const { Holes, Rounds } = this.entities        
        
        this.before(['CREATE', 'UPDATE'], Rounds, (req) => {
            log.info('=======> Before CREATE / UPDATE Rounds start')
            if( req.data.holes ){
                for( let hole of req.data.holes){
                    if ( hole.score && hole.par ){
                        hole.result_code = calculateResult(hole.par, hole.score)
                        log.info("score", hole.score, "result", hole.result_code)
                    }
                }
            }
            log.info('=======> Before CREATE / UPDATE Rounds end')
        })

        // CREATE operation on entiyt Holes
        this.before ('UPDATE', Holes, req => {          
            req.data.result_code = calculateResult(req.data.par, req.data.score)
        })
        
        // CREATE operation on entiyt Holes
        this.before ('CREATE', Holes, req => {          
            req.data.result_code = calculateResult(req.data.par, req.data.score)
        })

        const remote = await cds.connect.to("RemoteService")
        this.on('*', 'Players', (req) => {
            console.log(">> delegating to remote service")
            return remote.run(req.query)
        })

        return super.init()
    }
}