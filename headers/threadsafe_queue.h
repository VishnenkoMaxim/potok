#pragma once

#include <list>
#include <mutex>

template<typename T>
class threadsafeList
{
public:
    class lockedAccess
    {
    public:
        explicit lockedAccess(threadsafeList& owner)
            : mOwner(owner)
            , mLock(owner.mMutex){}

        lockedAccess(const lockedAccess&) = delete;
        lockedAccess& operator=(const lockedAccess&) = delete;

        std::list<T>& get() { return mOwner.mQueue; }
        const std::list<T>& get() const { return mOwner.mQueue; }

    private:
        threadsafeList& mOwner;
        std::unique_lock<std::mutex> mLock;
    };

    void lock() { mMutex.lock(); }
    void unlock() { mMutex.unlock(); }

    void lock() const { mMutex.lock(); }
    void unlock() const { mMutex.unlock(); }

    std::list<T>& get() { return mQueue; }
    const std::list<T>& get() const { return mQueue; }

    lockedAccess RaiiLock() { return lockedAccess(*this); }

private:
    mutable std::mutex mMutex;
    std::list<T> mQueue;
};
