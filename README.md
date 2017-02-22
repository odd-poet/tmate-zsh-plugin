# tmate plugin

[tmate]는 `tmux`를 fork한 툴로 `tmux` 세션 공유를 쉽게 도와주는 툴이다.
(`tmux`와 `tmate`는 동시에 설치되어 있어도 무방하단다)

## features

`tmate`는 `-S` 옵션으로 *socketfile*을 직접 지정하여 사용하는 것을 권하는데,
이 플러그인은 session 이름으로 socketfile을 생성하고 관리해주며 session에 대한 자동완성을 지원한다.
(`tmate`는 하나의 *socket*에 다수의 *session*을 생성하는 것을 지원하지 않는다.)

- `tmnew`
  - 세션 생성
- `tma`
  - 세션 attach
- `tmkill`
  - 세션 kill
- `tmls`
  - 세션 목록
- `tmshare`
  - 세션 공유에 필요한 접속정보를 출력한다.
- `tm_socket` : (디버그용)
  - 세션에 대한 socket 파일 출력.

## install

```
git clone git@github.com:odd-poet/tmate-zsh-plugin.git ~/.oh-my-zsh/plugins/tmate
```

[tmate]:https://tmate.io/
