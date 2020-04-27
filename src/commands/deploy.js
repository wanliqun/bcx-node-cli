const {Command, flags} = require('@oclif/command')
const {bcxSDK} = require('../bcx/sdk.js')

class DeployCommand extends Command {
  async run() {
    const {flags} = this.parse(DeployCommand)
    const name = flags.name || 'world'
    this.log(`hello ${name} from ./src/commands/deploy.js`)

    bcxSDK.queryBlock({
      block:1000
    }).then(res=>{
      console.info("queryBlock res",res);
    })
  }
}

DeployCommand.description = `Describe the command here
...
Extra documentation goes here
`

DeployCommand.flags = {
  name: flags.string({char: 'n', description: 'name to print'}),
}

module.exports = DeployCommand
