FROM rocker/tidyverse:4.0.3

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    zlib1g-dev \
  && install2.r --error \
      curl \
      # Rcurl \
      R.utils \
      data.table \
      magrittr \
      stargazer \
      sandwich \
      lmtest \
      # lfe \
      AER \
      ri
