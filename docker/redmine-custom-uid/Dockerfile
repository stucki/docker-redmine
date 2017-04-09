FROM redmine:3.3

COPY docker-entrypoint-custom.sh /
ENTRYPOINT ["/docker-entrypoint-custom.sh"]

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
