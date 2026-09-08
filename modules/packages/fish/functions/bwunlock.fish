function bwunlock
    set -gx BW_SESSION (bw unlock --raw)
end
