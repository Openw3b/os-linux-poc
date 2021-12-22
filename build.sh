sudo rm fs/fs.tar fs/fs.qcow2
DOCKER_BUILDKIT=1 docker build --output "type=tar,dest=fs/fs.tar" .
sudo virt-make-fs --format=qcow2 --size=+1G fs/fs.tar fs/fs.qcow2
sudo chown neo:neo fs/fs.qcow2
