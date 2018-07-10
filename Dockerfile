FROM continuumio/miniconda3:latest
RUN conda install -qy \
	-c m-labs/label/dev -c m-labs -c defaults -c conda-forge \
	nomkl artiq && \
	conda clean -tipsy
ENTRYPOINT []
CMD [ "/bin/bash" ]
