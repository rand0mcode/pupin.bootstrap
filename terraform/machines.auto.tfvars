machines = {
    puppetca  = { ip = "10.0.8.7",  server_type = "cx21", image = "centos-8" }
    puppet    = { ip = "10.0.8.8",  server_type = "cx21", image = "centos-8" }
    puppetdb  = { ip = "10.0.8.9",  server_type = "cx11", image = "centos-8" }
    agent01   = { ip = "10.0.8.11", server_type = "cx11", image = "centos-8" }
    # monitoring
    monitor01 = { ip = "10.0.8.12", server_type = "cx11", image = "centos-8" }
    monitor02 = { ip = "10.0.8.13", server_type = "cx11", image = "centos-8" }
}
