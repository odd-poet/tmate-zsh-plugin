# tmate plugin

tmate [oh-my-zsh] plugin.

[tmate]는 `tmux`를 fork한 툴로 `tmux` 세션 공유를 쉽게 도와주는 툴이다.
(`tmux`와 `tmate`는 동시에 설치되어 있어도 무방하단다)

## features

`tmate`는 `-S` 옵션으로 *socketfile*을 직접 지정하여 사용하는 것을 권하는데,
이 플러그인은 session 이름으로 socketfile을 생성하고 관리해주며 session에 대한 자동완성을 지원한다.
(`tmate`는 하나의 *socket*에 다수의 *session*을 생성하는 것을 지원하지 않는다.)

- `tm`
  - 세션 생성 및 attch
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
- `tmhelp` 
  - 도움말 

## install

`oh-my-zsh`과 `tmate`를 설치한 후에 아래와 같이 설치. 

```bash
git clone git@github.com:odd-poet/tmate-zsh-plugin.git ~/.oh-my-zsh/plugins/tmate
```

그리고 `~/.zshrc`에 plugin을 추가해준다. 

```zsh
# ~/.zshrc의 plugin 설정부분
plugins=(...중략... tmate)
```


기본 `.tmux.conf`파일도 동봉되어 있으니 홈 디렉토리로 복사해서 사용할 수 있다. 

```zsh
cp ~/.oh-my-zsh/plugins/tmate/.tmux.conf ~/.tmux.conf
```

[tmate]는 **tmux**의 fork이니 session 내에서의 단축키는 tmux의 것들을 참고하자. 
- [tmux 입문자 시리즈 요약](https://edykim.com/ko/post/tmux-introductory-series-summary/)

[tmate]:https://tmate.io/
[oh-my-zsh]:https://github.com/robbyrussell/oh-my-zsh
