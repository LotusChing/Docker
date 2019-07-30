FROM python:3.6.9
RUN pip install webob
RUN git clone https://github.com/LotusChing/anki-sync-server.git
RUN cd anki-sync-server && git submodule update --init \
    && sed -r -i 's/pyaudio/# pyaudio/g' anki-bundled/requirements.txt \
    && pip install -r anki-bundled/requirements.txt

ENV USERNAME=""
ENV PASSWORD=""

WORKDIR /anki-sync-server
ADD entrypoint.sh /
EXPOSE 27701
CMD ["/entrypoint.sh", "$USERNAME", "$PASSWORD"] 
