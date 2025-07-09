다음 repository를 참고하여, pyspark로 인구통계학적 데이터 처리하는 예제

> https://github.com/dispatch-yt/pyspark-demographic-data-processing

실행중에 발생한 문제와 해결 방법을 정리합니다.

## 문제

### case 1.
```
java.lang.IllegalArgumentException: basedir must be absolute: ?/.ivy2.5.2/local at org.apache.ivy.util.Checks.checkAbsolute(Checks.java:48)
```
해결

```--conf "spark.jars.ivy=/opt/bitnami/spark/.ivy"``` 


### case 2.

```
Caused by: org.apache.hadoop.security.KerberosAuthException: failure to login: javax.security.auth.login.LoginException: java.lang.NullPointerException: invalid null input: name
```

해결

PUID, PGID 환경변수 설정, user 설정 (docker-compose.yml)

```dockerfile
    environment:
      - PUID=${PUID}
      - PGID=${PGID}
    user: ${PUID}:${PGID}
```

## 실행

```sehll
> docker-compose up
```

container 실행 후, container id 확인
```shell
> docker ps |  grep master
4328389baefe   bitnami/spark:latest   "/opt/bitnami/script…"   ...
```

spark-submit 실행
```shell
> docker exec -it 4328389baefe spark-submit --conf "spark.jars.ivy=/opt/bitnami/spark/.ivy" /opt/bitnami/spark/jobs/process.p 
```


## 참고
- https://hub.docker.com/r/bitnami/spark