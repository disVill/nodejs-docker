# nodejs-docker
Node.jsをDocker上で動かす際のベストプラクティス

[この記事](https://blog.shinonome.io/nodejs-docker/)で作成したDockerfileなどを入れています

## ビルド
```bassh
docker build -t nodejs-docker .
```

## 実行
```bash
docker run -p 3000:3000 nodejs-docker
```

## 停止
```bash
docker stop `docker container ls -lq`
```
