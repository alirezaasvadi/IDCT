function [cnt,or,mi,flg] = cntd(cnt,or,mi,mp)

%% object localization
cntp  = cnt;                                                    % save present centroid for the next frame ...
                                                                % in case if there was no centroid in the next frame
%% limit the search area to the object area
Ao    = zeros(size(mp,1),size(mp,2));
Ao(or(2):or(2) + or(4),or(1):or(1) + or(3)) = 1;                % object area
mp    = mp .* Ao;                                               % use object area of map 
%% if there was an object compute new centroid & check if mean-shift iteration conditions are met
if sum(mp(:)) ~= 0;
    [r,c] = find(mp ~= 0);                                      % compute gray level centroid
    r     = r .* mp(mp ~= 0);                                   % weighted rows
    c     = c .* mp(mp ~= 0);                                   % weighted column
    cnt   = round( sum([c r]) / sum(mp(:)) );                   % gray level centroid

    or    = round([cnt(1)-or(3)/2 cnt(2)-or(4)/2 or(3) or(4)]); % move object rectangle center to the new centroid
    or    = prext(or,mp);                                       % keep rectangle in image (prevent error)
    mi    = mi + 1;                                             % increase mean-shift iteration
    if norm(cnt - cntp) < 2                                     % if centroid does not changed, break  
      flg = 0;              
    else
      flg = 1;
    end
    if mi == 4                                                  % if reached max iteration, break
      flg = 0;
    end
%% if there was no object use previous centroid   
else                                                            % if there was no centroid in the present frame ...
    cnt   = cntp;                                               % use computed centroid in the previous frame
    flg   = 0;                                                  % all output arguments should be assigned
end

end