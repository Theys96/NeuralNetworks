function timestep = find_time_thres(errvec,thres)
  i = 1;
  while 1
    if errvec(i) <= thres
      timestep = i;
      break;
    end
    i = i+1;
  end
end