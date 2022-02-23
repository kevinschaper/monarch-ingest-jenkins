FROM python:3.8

#ARG GID
#ARG UID
#ARG UNAME
#
#ENV GROUP_ID=$GID
#ENV USER_ID=$UID
#ENV USERNAME=$UNAME

#RUN mkdir -p /home/$USERNAME

#RUN groupadd -g $GROUP_ID $USERNAME
#RUN useradd -r -u $USER_ID -g $USERNAME -d /home/$USERNAME $USERNAME
#RUN chown $USERNAME:$USERNAME /home/$USERNAME

USER $USERNAME
WORKDIR /home/$USERNAME


RUN git clone https://github.com/monarch-initiative/monarch-ingest.git
WORKDIR "monarch-ingest"
RUN python -m venv venv
RUN ./venv/bin/pip install poetry

RUN . venv/bin/activate && poetry install

ENTRYPOINT ["poetry","run"]



