LiteSpeed Memcached - LSMCD Docker Image Builder
=======  
Mô tả - Description
--------
Sử dụng tiện ích này để tạo file ảnh của LiteSpeed Memcached - LSMemcached - LSMCD Docker

Xem hướng dẫn sử dụng bằng Tiếng Việt tại đây: https://workleast.com/cai-dat-litespeed-memcached-lsmcd-docker/

Use this builder to build your own LiteSpeed Memcached - LSMemcached -LSMCD Docker image.

Yêu cầu - Prerequisites
--------
- Docker & Docker Compose: https://github.com/docker/docker-install

Chạy trực tiếp từ Docker Hub - Pull directly from Docker Hub
--------
```
docker run --name lsmcd --shm-size 512m -d -p 11211:11211 --restart always workleast/lsmcd:latest
```
## Sử dụng docker compose - Use docker compose
```
- git clone https://github.com/workleast/lsmcd-docker.git
- cd lsmcd-docker
- docker compose up -d
```

Cách kiểm tra - How to test
--------
```
- telnet 127.0.0.1 11211
- stats
- quit
```

Hướng dẫn tự tạo file ảnh - How to build your own image
--------
```
- git clone https://github.com/workleast/lsmcd-docker.git
- cd lsmcd-docker
- sudo sh build.sh
```

Cấu hình theo yêu cầu - Customization
--------
Theo mặc định - by default:
- File ảnh LSMCD docker sẽ sử dụng phiên bản Ubuntu 22.04 (jammy). nếu bạn muốn phiên bản khác vui lòng thay đổi phần 'FROM' của file 'Dockerfile'

  The LSMCD docker image has been setup to base on Ubuntu 22.04 (jammy). if you want another version, please declare it in the 'FROM' command of the 'Dockerfile' file

- Container LSMCD sẽ sử dụng file cấu hình mặc định. Nếu bạn muốn thay đổi file này, xin thực hiện theo hướng dẫn bên dưới

  The LSMCD container will use the default configuration file. If you need to amend to it, please follow the below instructions
  ```
    - git clone https://github.com/workleast/lsmcd-docker.git
    - cd lsmcd-docker
    - nano docker-compose.yml
        volumes:
          - ./conf:/usr/local/lsmcd/conf
    - make changes to conf/node.conf file as needed
  ```

- LSMCD được cấu hình sử dụng bộ nhở chia sẻ để lưu dữ liệu đệm tại '/dev/shm'. Dữ liệu này sẽ mất đi sau khi tắt container. Nếu bạn muốn lưu dữ liệu đệm xuống ổ đĩa lưu trữ, xin thay đổi nội dụng trong file 'conf/node.conf' thành 'Cached.ShmDir=/usr/local/lsmcd/data' và thay đổi khai báo "volumes" trong file "docker-compose.yml". Vui lòng tham khảo các bước bên dưới để thực hiện. 

  LSMCD has been configured to use the shared memory device at '/dev/shm' to store its cache data which will be destroyed upon container restart. If you want to have cache data stored persistently on your storage disk, please modify 'conf/node.conf' with 'Cached.ShmDir=/usr/local/lsmcd/data' and uncomment "volumes" declaration in the 'docker-compose.yml' file. Please refer to the following steps to implement.
  ```
    - nano conf/node.conf
        #Cached.ShmDir=/dev/shm/lsmcd
        Cached.ShmDir=/usr/local/lsmcd/data
    - nano docker-compose.yml
        volumes:
          - ./conf:/usr/local/lsmcd/conf
          - ./data:/usr/local/lsmcd/data
  ```
- Để sử dụng Unix Socket thay cho giao thức TCP/IP, vui lòng thay đổi nội dung trong file "conf/node.conf" thành "CACHED.ADDR=UDS:///tmp/lsmcd.sock" và thay đổi khai báo "volumes" và "ports" trong file "docker-compose.yml". Xin tham khảo các bước bên dưới để thực hiện.

  In order to use Unix Socket instead of TCP/IP protocol, please modify 'conf/node.conf' with 'CACHED.ADDR=UDS:///tmp/lsmcd.sock' and alter "volumes" and "ports" declarations in the 'docker-compose.yml' file. Please refer to the following steps to implement.
   ```
    - nano conf/node.conf
        #CACHED.ADDR=0.0.0.0:11211
        CACHED.ADDR=UDS:///tmp/lsmcd.sock
    - nano docker-compose.yml
        volumes:
          - ./conf:/usr/local/lsmcd/conf
          - ./tmp:/tmp
        #ports:
          #- "11211:11211"
  ```
- Để kiểm tra kết nối Unix Socket, xin thực hiện lệnh sau:
  
  To test Unix Socket connection, please execute the below commands:
  ```
    - nc -U tmp/lsmcd.sock -C
    - stats
    - quit
  ```
Trần Nhuận Quang @ https://workleast.com
