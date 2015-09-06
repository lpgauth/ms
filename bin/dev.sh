#!/bin/bash
exec erl -sname ms_dev \
         -pa ebin deps/*/ebin test \
         -config config/dev \
         -boot start_sasl \
         -s ms_app \
         -setcookie secret
