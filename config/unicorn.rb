APP_PATH = '/home/safira'
working_directory APP_PATH

stderr_path APP_PATH + '/log/unicorn.stderr.log'
stdout_path APP_PATH + '/log/unicorn.stderr.log'

pid APP_PATH + '/tmp/pid/unicorn.pid'