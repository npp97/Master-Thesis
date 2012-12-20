function DM = diffm(datacoord,centercoord)
    %Notes590_Ch37
    [dr,cc] = ndgrid(datacoord(:),centercoord(:));
    DM = dr-cc;
end