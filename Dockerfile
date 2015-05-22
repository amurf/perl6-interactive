FROM rakudo-star
MAINTAINER Ashley Murphy <irashp@gmail.com>

RUN apt-get update && \
    apt-get install -y build-essential vim



COPY image-files/.vim /home/perl6/.vim
COPY image-files/.vimrc /home/perl6/
COPY image-files/.bashrc /home/perl6/
COPY image-files/.git-completion.sh /home/perl6/

RUN chown -R perl6:perl6 /home/perl6

USER perl6
WORKDIR /home/perl6
