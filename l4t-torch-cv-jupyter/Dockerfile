FROM locatible/l4t-torch-opencv:latest

RUN apt-get update -y && apt-get autoremove -y && apt-get install -y  python3-matplotlib && python3 -m pip install jupyterlab

USER dev
RUN mkdir /home/dev/notebooks
WORKDIR /home/dev

CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "/home/dev/notebooks/"]]

VOLUME /home/dev/notebooks
EXPOSE 8888
