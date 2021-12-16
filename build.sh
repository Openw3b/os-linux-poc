DOCKER_BUILDKIT=1 docker build --output "type=tar,dest=fs.tar" .
sudo virt-make-fs --format=qcow2 --size=+1G fs.tar fs.qcow2
sudo chown user:user fs.qcow2
