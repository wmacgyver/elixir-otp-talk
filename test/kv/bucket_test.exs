defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, bucket} = KV.Bucket.start_link
    {:ok, bucket: bucket}
  end

  test "stores values by key", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "paladin") == nil

    KV.Bucket.put(bucket, "paladin", 1)
    assert KV.Bucket.get(bucket, "paladin") == 1
  end
end
