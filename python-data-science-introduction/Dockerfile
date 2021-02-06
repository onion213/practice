FROM jupyter/minimal-notebook:latest

RUN conda update --all --yes
RUN conda install --yes \
#    scikit-learn \
#    tensorflow \
    pytorch torchvision -c pytorch
RUN conda install -c conda-forge ipywidgets