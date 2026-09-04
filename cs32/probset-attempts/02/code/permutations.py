def permute(nums):
    path = []
    used = [False] * len(nums)

    def backtrack():
        if len(path) == len(nums):
            yield path[:]
            return

        for i in range(len(nums)):
            if used[i]:
                continue
            used[i] = True
            path.append(nums[i])
            yield from backtrack()
            path.pop()
            used[i] = False

    yield from backtrack()

nums = [1, 2, 3]
for p in permute(nums):
    print(p)