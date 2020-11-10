from pyftpdlib.authorizers import DummyAuthorizer
from pyftpdlib.handlers import FTPHandler
from pyftpdlib.servers import FTPServer

authorizer = DummyAuthorizer()
authorizer.add_user("lev", "123", "d://documents//2", perm="elradfmwMT")
#authorizer.add_anonymous("d://documents//2")

handler = FTPHandler
handler.authorizer = authorizer

server = FTPServer(("192.168.1.149", 21), handler)
server.serve_forever()