LiteSpeed Memcached - LSMCD Docker Image Builder
=======  
Mô tả - Description
--------
Sử dụng tiện ích này để tạo file ảnh của LiteSpeed Memcached -LSMemcached - LSMCD Docker

Use this builder to build your own LiteSpeed Memcached - LSMemcached -LSMCD Docker image.

Yêu cầu - Prerequisites
--------
- Docker & Docker Compose: https://github.com/docker/docker-install

Chạy trực tiếp từ Docker Hub - Pull directly from Docker Hub
--------
```
docker pull workleast/lsmcd
```
```
docker run --rm --name lsmcd --shm-size 512m -d -p 11211:11211 workleast/lsmcd:latest
```
## Sử dụng docker compose - Use docker compose
```
- mkdir lsmcd-docker
- cd lsmcd-docker
- wget https://github.com/workleast/lsmcd-docker/raw/main/docker-compose.yml
- docker compose up -d
```

Cách kiểm tra - How to test
--------
```
- telnet 127.0.0.1 11211
- stats
- stop
```

Hướng dẫn tự tạo file ảnh - How to build your own image
--------
```
- git clone https://github.com/workleast/lsmcd-docker.git
- cd lsmcd-docker
- sudo sh build.sh
```

Chỉnh sửa theo yêu cầu - Customization
--------
Theo mặc định - by default:
- File ảnh LSMCD docker sẽ sử dụng phiên bản Ubuntu 22.04 (jammy). nếu bạn muốn phiên bản khác vui lòng thay đổi phần 'FROM' của file 'Dockerfile'

The LSMCD docker image has been setup to base on Ubuntu 22.04 (jammy). if you want another version, please declare it in the 'FROM' command of the 'Dockerfile' file

- LSMCD được cấu hình sử dụng bộ nhở chia sẻ từ máy chủ để lưu dữ liệu tại '/dev/shm'. Dữ liệu này sẽ mất đi sau khi tắt Docker. Nếu bạn muốn lưu xuống ổ đĩa lưu trữ, vui lòng thay đổi mục 'Cached.ShmDir' trong file 'conf/node.conf' thành 'Cached.ShmDir=/usr/local/lsmcd/data'. Vui lòng tham khảo các bước bên dưới để thực hiện. 

LSMCD has been configured to use the host's shared memory at /dev/shm to store its cache data which will be destroyed upon container restart. If you want to have cache data stored persistently on your storage disk, please modify 'conf/node.conf' with 'Cached.ShmDir=/usr/local/lsmcd/data' and uncomment volumes declarations in the 'docker-compose.yml' file. Please refer to the following steps to implement.
```
- mkdir -p lsmcd-docker/conf
- cd lsmcd-docker/
- wget https://github.com/workleast/lsmcd-docker/raw/main/docker-compose.yml
- wget -P ./conf https://github.com/workleast/lsmcd/raw/lsmcd-docker-image/dist/conf/node.conf
- nano conf/node.conf
    Cached.ShmDir=/usr/local/lsmcd/data
- nano docker-compose.yml
    volumes:
      - ./conf:/usr/local/lsmcd/conf
      - ./data:/usr/local/lsmcd/data
      - ./tmp:/tmp
- docker compose up -d
```
Trần Nhuận Quang @ https://workleast.com
