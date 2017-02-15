import Foundation
import HeliumLogger
import Kitura
import KituraNet

HeliumLogger.use()

let router = Router()

// TODO: Add https server to Kitura app.

Kitura.addHTTPServer(onPort: 80, with: router)

Kitura.run()
