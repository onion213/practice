FROM jupyter/minimal-notebook:latest

RUN conda update --all --yes
RUN conda install --yes \
#    scikit-learn \
#    tensorflow \
    -c conda-forge pytorch torchvision torchaudio cpuonly -c pytorch
RUN conda install -c conda-forge ipywidgets
RUN conda install -c conda-forge matplotlib
