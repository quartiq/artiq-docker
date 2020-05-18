FROM continuumio/miniconda3:latest

ARG CACHE_DATE_BASE=2020-05-18

RUN conda install -qy \
	-c m-labs/label/dev -c m-labs -c defaults -c conda-forge \
	nomkl artiq && \
	conda clean -tipsy

ENTRYPOINT []
CMD [ "/bin/bash" ]
