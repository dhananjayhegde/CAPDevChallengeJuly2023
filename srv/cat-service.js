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

module.exports = class GolfService extends cds.ApplicationService {
    async init() {
        console.log("reached init...")
        const { Holes } = this.entities
        this.before ('CREATE', Holes, req => {
          if(req.data.score == 1){
              req.data.result = "hole in one"
          } else {
              const res = req.data.score - req.data.par
              req.data.result = SCOREMAPPING[ res.toString() ]
          }
        })

        const remote = await cds.connect.to("RemoteService")
        this.on('*', 'Players', (req) => {
            console.log(">> delegating to remote service")
            return remote.run(req.query)
        })

        return super.init()
    }
}