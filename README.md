LSMCD Docker Image Builder
=======  
Mô tả - Description
--------
Sử dụng tiện ích này để tạo file ảnh của LiteSpeed Memcached - LSMCD Docker

Use this builder to build your own LiteSpeed Memcached - LSMCD Docker image.

Yêu cầu - Prerequisites
--------
- Docker & Docker Compose: https://github.com/docker/docker-install

Hướng dẫn tạo file ảnh - How to build docker image
--------
- git clone https://github.com/workleast/lsmcd-docker.git
- cd lsmcd-docker
- sudo sh build.sh

Hướng dẫn sử dụng - How to use
--------
- docker compose up

hoặc - or

- docker compose up -d

Cách kiểm tra - How to test
--------
- telnet 127.0.0.1 11211

Chỉnh sửa theo yêu cầu - Customization
--------
Theo mặc định - by default:
- File ảnh LSMCD docker sẽ sử dụng phiên bản Ubuntu 22.04 (jammy). nếu bạn muốn phiên bản khác vui lòng thay đổi phần 'FROM' của file 'Dockerfile'

The LSMCD docker image has been setup to base on Ubuntu 22.04 (jammy). if you want another version, please declare it in the 'FROM' command of the 'Dockerfile' file

- LSMCD được cấu hình sử dụng bộ nhở chia sẻ để lưu dữ liệu tại '/dèv/shm', dữ liệu này sẽ mất sau khi tắt Docker. Nếu bạn muốn lưu xuống ổ đĩa lưu trữ vui lòng thay đổi trong file 'conf/node.conf', mục 'Cached.ShmDir' thành 'Cached.ShmDir=/usr/local/lsmcd/data'

LSMCD has been configured to use the host's shared memory at /dev/shm to store its cache data which will be destroyed upon container restart. If you want to have cache data stored persistently on your storage disk, please modify 'conf/node.conf' with 'Cached.ShmDir=/usr/local/lsmcd/data'

Trần Nhuận Quang @ https://workleast.com
