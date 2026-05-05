FROM pytorch/pytorch:2.4.1-cuda12.4-cudnn9-runtime

LABEL author="Portia Cooper"
LABEL description="Default container definition for class competition. But I had to upgrade pytorch to make it work with the modern sentence transformers library. And then had to upgrade/swap the packages."

# Create app directory
WORKDIR /app

RUN pip install --no-cache-dir \
    pytorch-lightning==2.4.0 \
    graphviz==0.20.3 \
    ipython>=8.18 \
    notebook>=7.2 \
    jupyterlab>=4.2 \
    pandas==2.2.2 \
    numpy==1.26.4 \
    matplotlib==3.8.4 \
    seaborn==0.13.2 \
    sentence-transformers==2.7.0 \
    scikit-learn==1.5.2 \
    ipywidgets>=8.1 \
    && pip cache purge

# copy executables to path
COPY . ./
RUN chmod u+x  scripts/* \
    && mv scripts/* /usr/local/bin/ \
    && rmdir scripts

# launch jupyter by default
CMD ["/bin/bash", "launch-notebook"]