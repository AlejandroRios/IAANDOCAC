function ltail=size_tailcone(NPax,PEng,fuse_height,fuse_width)
%  Provide a sizing of the tailcone
fusext   = 0;
if NPax <= 50
%passenger baggage 200 kg/m3 e 20 kg por pax
bagvol=NPax*20/200;   % m3
fusext    = 4*bagvol/(pi*(fuse_height-2*fuse_width)*(fuse_height-2*fuse_width));
end
    if PEng == 2
    ltail_df=2.25;  
    else
    ltail_df=2.0; % relacao coni/diametro Roskam vol 2 pag 110
    end
ltail = ltail_df*fuse_width+fusext;
end % function