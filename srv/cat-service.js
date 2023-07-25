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
    init() {
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

        return super.init()
    }
}