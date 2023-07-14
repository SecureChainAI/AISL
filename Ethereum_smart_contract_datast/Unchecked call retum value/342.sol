function count(
    slice memory self,
    slice memory needle
) internal pure returns (uint cnt) {
    uint ptr = findPtr(self._len, self._ptr, needle._len, needle._ptr) +
        needle._len;
    while (ptr <= self._ptr + self._len) {
        cnt++;
        ptr =
            findPtr(
                self._len - (ptr - self._ptr),
                ptr,
                needle._len,
                needle._ptr
            ) +
            needle._len;
    }
}
