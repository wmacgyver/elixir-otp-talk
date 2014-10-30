defmodule KV.RegistryTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, registry} = KV.Registry.start_link
    {:ok, registry: registry}
  end

  test "spawns buckets", %{registry: registry} do
    assert KV.Registry.lookup(registry, "team") == :error

    KV.Registry.create(registry, "team")
    assert {:ok, bucket} = KV.Registry.lookup(registry, "team")

    KV.Bucket.put(bucket, "cleric", 18)
    assert KV.Bucket.get(bucket, "cleric") == 18
  end

  test "removes buckets on exit", %{registry: registry} do
    KV.Registry.create(registry, "team")
    {:ok, bucket} = KV.Registry.lookup(registry, "team")
    Agent.stop(bucket)
    assert KV.Registry.lookup(registry, "team") == :error
  end
end
