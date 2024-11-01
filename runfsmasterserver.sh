apt-get update && apt-get install -y apt-transport-https ca-certificates curl iproute2

SEAWEEDFS_VER=3.77

# choose either URL
DOWNLOAD_URL=https://github.com/seaweedfs/seaweedfs/releases/download

rm -f /tmp/seaweedfs-${SEAWEEDFS_VER}-linux-amd64_full.tar.gz
rm -rf /tmp/seaweedfs && mkdir -p /tmp/seaweedfs

curl -L ${DOWNLOAD_URL}/${SEAWEEDFS_VER}/linux_amd64_full.tar.gz -o /tmp/seaweedfs-${SEAWEEDFS_VER}-linux-amd64_full.tar.gz
tar xzvf /tmp/seaweedfs-${SEAWEEDFS_VER}-linux-amd64_full.tar.gz -C /tmp/seaweedfs
rm -f /tmp/seaweedfs-${SEAWEEDFS_VER}-linux-amd64_full.tar.gz

listen_ip=$(ip a | awk "/inet/ && /brd/" | tail -1 | awk '{print $2}' | awk -F/ '{print $1}')

mkdir /tmp/seaweedfs/masterdir
/tmp/seaweedfs/weed master -mdir=masterdir -port.grpc=$1 -port=$2
# /tmp/seaweedfs/weed master -mdir=masterdir -peers=$1 -ip=${listen_ip} -defaultReplication=002
# /tmp/seaweedfs/weed master -port.grpc=$1 -port=$2 -mdir=masterdir