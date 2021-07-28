

docker run -d -p 8080:8080 --name ssm_tomcat -v volume_ssm_tomcat:/root/tomcat a5b657

//未完成
docker run -d -p 8080:8080 --name ssm_tomcat -v /G/ss:/usr/local/tomcat 0e47688cc516
#运行容器
 # -d 后台运行
 # -p win10端口:容器端口 容器端口映射win10端口
 # tomcat  镜像名称 简写名称
 # 0e47688cc516 ID
 # 访问 localhost:8081
 docker run -d -p 8081:8080 --name tomcat 0e47688cc516



 #---------------!!! 报错无法启动tomcat
 # tomcat:
 #   restart: always
 #   image: daocloud.io/library/tomcat:8.5.15-jre8-alpine
 #   container_name: tomcat
 #   ports:
 #     - 8080:8080
 #   volumes:
 #     - .:/usr/local/tomcat/webapps
 #     - .:/usr/local/tomcat/logs
 #---------------!!!

 ERROR: The Compose file '.\docker-compose.yml' is invalid because:
 services.mysql.environment.volumes contains [".:/var/lib/mysql"], which is an invalid type, it should be a string, number, or a null



